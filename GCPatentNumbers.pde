/*
Glenn Chon
Data Visualization
Assignment 5
Automation Project
GCPatentNumbers
*/

import java.util.regex.*;

PrintWriter patentNums;

void setup(){
  
  //string base contains search terms: intelligent OR intelligence AND computer
  String base = "http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&u=%2"
  +"Fnetahtml%2FPTO%2Fsearch-adv.htm&r=0&f=S&l=50&d=PALL&OS=intelligent+OR+intelligence+"
  +"AND+computer&RS=%28%28intelligent+OR+intelligence%29+AND+computer%29&Query=intelligen"
  +"t+OR+intelligence+AND+computer&TD=133530&Srch1=%28%28intelligent+OR+intelligence%29+"
  +"AND+computer%29&NextList";
  
  
  patentNums = createWriter("patentNums.tsv");//writer
  for (int i = 1; i < 2672; i++){//pull patent numbers from 2,671 pages
    if (i % 50 == 0){
      println("Curently at page " + i); // just to see progress
    }
    parseUSPTO(loadStrings(base + i + "=Next+50+Hits"));
  }
    
  patentNums.flush();
  patentNums.close();
  
  println("Phew, that was a lot of patent numbers");
}

void parseUSPTO(String[] lines){
  String htmlString = "";
  String pNum = "";
  String one = "";
  String two = "";
  String three = "";
  String[] splitString;
  
  Pattern p = Pattern.compile("(\\d).(\\d{3}).(\\d{3}).*");
  
  for (int i = 0; i < lines.length; i++){
    htmlString = lines[i];
    //println(htmlString); //test to see if I actually got the html strings
    splitString = htmlString.split(">"); //splits string by ">" character
    for (int b = 0; b < splitString.length; b++){
      //println(splitString[b]); //test to see if I actually got them to split where I want
      Matcher m = p.matcher(splitString[b]);
    
      if (m.matches()){
        
        one = m.group(1);
        two = m.group(2);
        three = m.group(3);
        
        pNum = one + two + three;
        patentNums.println(pNum);
      }
    }
  }
}