var app_name = angular.module('app_name', []);

app_name.controller('ctrl1', function($scope){
    $scope.updateValue = function() {
        $scope.final_name = $scope.name;
    }

});