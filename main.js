var app_name = angular.module('app_name', []);

app_name.controller('ctrl1', function($scope){
    
    $scope.items = [];
    
   $scope.writeData = function() {
        firebase.database().ref('Items/' + $scope.name).set({
            name: $scope.name,
            waste_description: $scope.desc,
            waste_type: $scope.type
            });
    }

    var init = function(){
        var ref = database.ref('Items/');
        ref.on('value', function(snapshot){
            console.log(snapshot.val());
            var data = snapshot.val();
            var keys = Object.keys(data);
            for(var i = 0; i < keys.length; i++){
                var k = keys[i]
                var item = data[k].name;
                $scope.items.push(item);
            }
        });
        
    }

    init();
});