
var items = [];
var ref;
var item_details = [];
var n = 0;
ref = database.ref('Organization/');
ref.on('value', function(snapshot){
    var data = snapshot.val();
    var keys = Object.keys(data);
    for(var i = 0; i < keys.length; i++){
        var k = keys[i]
        var item = data[k].name;
        items.push(item);
    }
    
    items.forEach(element => {
        document.write("<br>");
        
        ref = database.ref('Organization/' + element);
        ref.on('value', function(snapshot){
            var data = snapshot.val();
            var keys = Object.keys(data);
            for(var i = 0; i < keys.length; i++){
                var k = keys[i]
                var item = data[k];
                item_details.push(item);
            }
            item_details.push("<hr>");
        });
        
    });
    item_details.forEach(element => {
        document.write("<br>");
        document.write(element);
    });

    
    
    
});

console.log(item_details);