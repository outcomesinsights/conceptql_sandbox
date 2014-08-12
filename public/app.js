var app = angular.module('myApp', []);

app.controller('MyCtrl', function($scope, $http) {
  $scope.loadStatement = function() {
    console.log($scope.statementPath);
    if(!$scope.statementPath || $scope.statementPath == "") {
      return;
    }
    $http.get('/statements.json', { params: { path: $scope.statementPath } }).success(function(data) {
      console.log(data);
      $scope.statement = data.statement;
      $scope.tryIt();
    })
  }

  var loadSQL = function(statement) {
    var displayIt = function(formatted_data) {
      $scope.query = formatted_data.result;
    };

    $http.get('/api/v0/sql', { params: { conceptql: statement } }).success(function(data) {
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
    $http.get('/to_yaml', { params: { conceptql: statement } }).success(function(data) {
      $scope.yaml = data.yaml;
    });
  };

  var loadDiagram = function(statement) {
    console.group("dia")
    console.log(statement)
    console.groupEnd('dia')
    $http.get('/api/v0/diagram', { params: { conceptql: statement } }).success(function(data) {
      $scope.img_src = data.img_src;
    });
  };

  $scope.tryIt = function () {
    var statement = angular.fromJson($scope.statement)
    loadSQL($.extend(true, {}, statement));
    loadYAML($.extend(true, {}, statement));
    loadDiagram($.extend(true, {}, statement));
    $scope.statement = angular.toJson(statement, true)
  };
});
