var app = angular.module('myApp', []);

app.controller('MyCtrl', function($scope, $http) {
  $scope.statement = '{ "union": [ { "icd9": "412" }, { "cpt": "99214" } ] }';
  $scope.loadStatement = function(statement) {
    $http.get('/' + statement + '.json').success(function(data) {
      console.log(data)
      $scope.statement = data.statement
      $scope.tryIt();
    })
  }
  $scope.query = "Query will appear here";
  $scope.tryIt = function () {
    var statement = angular.fromJson($scope.statement)
    var displayIt = function(formatted_data) {
      console.log(formatted_data);
      $scope.query = formatted_data.result;
      console.log($scope.query);
    }
    console.log(statement)
    $scope.statement = angular.toJson(statement, true)
    $http.post('statement', statement).success(function(data) {
      //$http.post('http://sqlformat.org/api/v1/format', { sql: data.query })
      /*
      $http.post('http://sqlformat.org/api/v1/format', { reindent: 1, sql: 'SELECT * FROM table;' }, { responseType: 'json' })
                .success(displayIt)
                .error(displayIt);
                */
      $scope.img_src = data.img_src
      $http( { url: 'http://sqlformat.org/api/v1/format',
            method: 'POST',
            responseType: 'JSON',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            data: $.param({ reindent: 1, sql: data.query })})
                .success(displayIt)
                .error(displayIt);
      /*
      jQuery.ajax({
        url: 'http://sqlformat.org/api/v1/format',
        type: 'POST',
        dataType: 'json',
        crossDomain: true,
        data: {sql: data.query, reindent: 1},
        success: displayIt,
      });
      */
    });
  };
});
