var items = [];
var ref;
const refer = firebase.storage().ref();



function writeData() {
    console.log((document.getElementById("name").val));
    firebase.database().ref('Items/' + document.forms["myform"]["name"].value).set({
        name: document.forms["myform"]["name"].value,
        waste_description: document.forms["myform"]["desc"].value,
        waste_type: document.forms["myform"]["type"].value,
        waste_image: document.forms["myform"]["img"].value
        }); 

}

function viewWaste(){
    ref = database.ref('Items/');
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

}

function viewOrg(){
    ref = database.ref('Organization/');
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

}
function  viewFeed(){
    ref = database.ref('Feedbacks/');
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

}