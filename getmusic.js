function getStr(patt, txt){
  var str, s='';
  while ((str = patt.exec(txt)) != null){
  s += str[1]+'\t'+str[2]+'\r\n';
  }
  return s;
}
var reg = /"song_mid":"([^"]+)/g;
var htmltxt = WScript.StdIn.ReadAll();
WSH.echo(getStr(reg, htmltxt));