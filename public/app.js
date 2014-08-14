var app = angular.module('myApp', []);

app.controller('MyCtrl', function($scope, $http) {
  $scope.loadStatement = function() {
    if(!$scope.statementPath || $scope.statementPath == "") {
      return;
    }
    $http.get('/statements.json', { params: { path: $scope.statementPath } }).success(function(data) {
      $scope.statement = data.statement;
      $scope.tryIt();
    })
  }

  $scope.$watch('statementPath', function() {
    $scope.loadStatement();
  });

  var loadSQL = function(statement) {
    $scope.query = null;
    var displayIt = function(formatted_data) {
      $scope.query = formatted_data.result;
    };

    $http.post('/api/v0/sql', statement).success(function(data) {
      $http( { url: 'http://sqlformat.org/api/v1/format',
            method: 'POST',
            responseType: 'JSON',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            data: $.param({ reindent: 1, sql: data.sql })})
                .success(displayIt)
                .error(displayIt);
    });
  };

  var loadYAML = function(statement) {
    $scope.yaml = null;
    $http.post('/to_yaml', statement).success(function(data) {
      $scope.yaml = data.yaml;
    });
  };

  var loadDiagram = function(statement) {
    $scope.img_src = null;
    $http.post('/api/v0/diagram', statement).success(function(data) {
      $scope.img_src = data.img_src;
    });
  };

  $scope.tryIt = function () {
    var statement = angular.fromJson($scope.statement)
    $scope.copied = false;
    loadSQL($.extend(true, {}, statement));
    loadYAML($.extend(true, {}, statement));
    loadDiagram($.extend(true, {}, statement));
    $scope.statement = angular.toJson(statement, true)
  };

  preloadSomeExample = function() {
    // Grabbed the idea for parsing a URL from:
    // http://jsfiddle.net/PT5BG/4/
    var parser, hashy;
    parser = document.createElement('a');
    parser.href = window.location;

    var hashy;
    if (hashy = parser.hash) {
      $scope.statementPath = hashy.substr(1);
    }
  };

  preloadSomeExample();
});
