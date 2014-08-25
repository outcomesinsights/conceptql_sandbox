var app = angular.module('myApp', []);

app.controller('MyCtrl', function($scope, $http) {
  var loadExample = function(data) {
    $scope.title = data.title;
    $scope.description = data.description;
    if (data.statement) {
      $scope.statement = JSON.stringify(JSON.parse(data.statement), undefined, 2);
    }
    var hashId = data.hash_id;
    if (hashId && hashId != "") {
      loadSQL(hashId);
      loadYAML(hashId);
      loadPartialResults(hashId);
      loadDiagram(hashId);
      $scope.exampleUrl = $scope.urlify(hashId)
    }

  };

  $scope.clear = function() {
    $scope.yaml = null;
    $scope.query = null;
    $scope.img_src = null;
    $scope.partial_results = null;
    $scope.title = null;
    $scope.description = null;
    $scope.statement = null;
    $scope.exampleUrl = null;
  }

  $scope.fetchExample = function() {
    $scope.clear();
    createOrFetchExample({hash_id: $scope.exampleHashId})
  };

  $scope.$watch('exampleHashId', function() {
    $scope.fetchExample();
  });

  var loadSQL = function(hashId) {
    $scope.query = null;
    var displayIt = function(formatted_data) {
      $scope.query = formatted_data.result;
    };

    $http.get('/api/v0/sql/' + hashId).success(function(data) {
      $http( { url: 'http://sqlformat.org/api/v1/format',
            method: 'POST',
            responseType: 'JSON',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            data: $.param({ reindent: 1, sql: data.sql })})
                .success(displayIt)
                .error(displayIt);
    });
  };

  var loadYAML = function(hashId) {
    $scope.yaml = null;
    $http.get('/api/v0/yaml/' + hashId).success(function(data) {
      $scope.yaml = data.yaml;
    });
  };

  var loadPartialResults = function(hashId) {
    $scope.partial_results = null;
    $http.get('/api/v0/partial_results/' + hashId).success(function(data) {
      var pr = data.partial_results;
      $scope.partial_results = pr;
      if (pr[0]) {
        $scope.partial_results_keys = Object.keys(pr[0]);
      }
    });
  };

  var loadDiagram = function(hashId) {
    $scope.img_src = null;
    // Set the timeout for 10 minutes
    $http.get('/api/v0/diagram/' + hashId, { timeout: 600000 }).success(function(data) {
      $scope.img_src = data.img_src;
    });
  };

  var createOrFetchExample = function(attributes) {
    $http.post('/api/v0/create_example', attributes)
      .success(function(data) {
        loadExample(data);
      });
  };

  $scope.createExample = function () {
    var statement = angular.fromJson($scope.statement)
    $scope.statement = angular.toJson(statement, true)
    $scope.copied = false;
    createOrFetchExample({
      title: $scope.title,
      description: $scope.description,
      statement: $scope.statement
    });
  };

  preloadSomeExample = function() {
    // Grabbed the idea for parsing a URL from:
    // http://jsfiddle.net/PT5BG/4/
    var parser, hashy;
    parser = document.createElement('a');
    parser.href = window.location;

    var hashy;
    if (hashy = parser.hash) {
      $scope.exampleHashId = hashy.substr(1);
    }
  };

  $scope.urlify = function(hashId) {
    var parser;
    parser = document.createElement('a');
    parser.href = window.location;
    parser.path = '/';
    parser.hash = '#' + hashId;
    return parser.href;
  }

  preloadSomeExample();
});
