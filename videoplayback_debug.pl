#!/usr/bin/perl

use HTTP::Response;

$params= $ENV{'QUERY_STRING'};
@tokens=split('&', $params);

foreach $string (@tokens){ 

 @mess=split('=', $string);

 if(index($params, "audio")!=-1){
  if($mess[0] eq "range"){
   $range=$mess[1];
 
   #we need to read form the file directly
   #$command="curl --header \"Range: bytes=${range}\" http://127.0.0.1/audio.mp4";

   @length=split("-", $range);
   $content_length=$length[1]-$length[0]; 

   $command=`tail -c +${length[0]} audio.mp4 | head -c ${content_length}`;
   
   # we don't need to print out the status, the browser handles it
   #print "HTTP/1.1 200 OK\r\n";
 
   @headers=("Content-Type" , "audio/mp4", "Content-Length" , $content_length, "Accept-Ranges" , "bytes", "Connection" , "keep-alive", "Server" , "gvs 1.0", "Cache-Control" , "private, max-age=22303", "Access-Control-Allow-Origin" , "http://www.youtube.com", "Access-Control-Allow-Credentials" , "false", "Timing-Allow-Origin" , "http://www.youtube.com", "Last-Modified" , "Fri, 28 Jun 2013 14:34:55 GMT", "Date" , "Wed, 17 Jul 2013 14:28:52 GMT", "Expires" , "Wed, 17 Jul 2013 14:28:52 GMT");
  $header_ref=\@headers;

   $resp=HTTP::Response->new("200", "", $header_ref, $command);

   $correct_resp=$resp->as_string;
   $correct_resp =~ s/200 OK\n//;

   print $correct_resp;
  }
 }

 elsif(index($params, "video")!=-1){
  if($mess[0] eq "range"){
   $range=$mess[1];                                                                      
                                                                                         
   #we need to read form the file directly                                              
                                                                                         
   @length=split("-", $range);                                                           
   $content_length=$length[1]-$length[0]+1;                                             

   $command="tail -c +${length[0]} planet_360.mp4 | head -c ${content_length}"; 
                                                                                         
   # we don't need to print out the status, the browser handles it                       
   #print "HTTP/1.1 200 OK\r\n";                                                         
                                                                                         
   print "Content-Length: ", $content_length, "\r\n";                                    
   print "Last-Modified: Fri, 28 Jun 2013 14:34:55 GMT\r\n";                             
   print "Content-Type: video/mp4\r\n";                                                  
   print "Date: Wed, 17 Jul 2013 14:28:52 GMT\r\n";                                      
   print "Expires: Wed, 17 Jul 2013 14:28:52 GMT\r\nCache-Control: private, max-age=22303\r\nAccept-Ranges: bytes\r\nAccess-Control-Allow-Origin: http://www.youtube.com\r\nAccess-Control-Allow-Credentials: false\r\nTiming-Allow-Origin: http://www.youtube.com\r\nConnection: keep-alive\r\nX-Content-Type-Options: nosniff\r\nServer: gvs 1.0\n\r\n";

   print `$command`, "\r\n";
  }
 }
}
