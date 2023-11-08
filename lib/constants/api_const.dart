class ApiConst {
static  String  adress(String nameCityes)=>'https://api.openweathermap.org/data/2.5/weather?q=$nameCityes,&appid=41aa18abb8974c0ea27098038f6feb1b';
static  String getIcon (iconCode,int size){
  return 'http://openweathermap.org/img/wn/$iconCode@${size }x.png';
}

}