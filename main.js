var items = [];
var ref = database.ref('Items/');
        ref.on('value', function(snapshot){
            var data = snapshot.val();
            var keys = Object.keys(data);
            for(var i = 0; i < keys.length; i++){
                var k = keys[i]
                var item = data[k].name;
                items.push(item);
            }
            document.write(items);
        });

function writeData() {
    firebase.database().ref('Items/' + $scope.name).set({
        name: $scope.name,
        waste_description: $scope.desc,
        waste_type: $scope.type
        });       
}