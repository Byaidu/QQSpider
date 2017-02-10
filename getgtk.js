var str = WScript.StdIn.ReadAll();
var hash = 5381;
for(var i = 0, len = str.length; i < len; ++i){
    hash += (hash << 5) + str.charAt(i).charCodeAt();
}
WSH.echo(hash & 0x7fffffff);