var items = [];
var ref;
var item_details = [];
var n = 0;
ref = database.ref('Items/');
ref.on('value', function(snapshot){
    var data = snapshot.val();
    var keys = Object.keys(data);
    for(var i = 0; i < keys.length; i++){
        var k = keys[i]
        var item = data[k];
        items.push(item);
    }
    items.forEach(element => {
        for(key in element){
            var value = element[key];
            document.write("<br>");
            document.write(key + ":     " + value);
        }
        document.write("<hr>"); 
        
    });

    
    
    
});



console.log(items);