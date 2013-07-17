#!/usr/bin/perl

$params= $ENV{'QUERY_STRING'};
@tokens=split('&', $params);

foreach $string (@tokens){ 

 @mess=split('=', $string);

 if(index($params, "audio")!=-1){
  if($mess[0] eq "range"){
   $range=$mess[1];
   $command="curl --header \"Range: bytes=${range}\" http://127.0.0.1/audio.mp4";

   print "HTTP/1.1 200 OK\r\n";
   print "Content-Length: ", length($command), "\r\n";
   print "Last-Modified: Fri, 28 Jun 2013 14:34:55 GMT\r\n";
   print "Content-Type: audio/mp4\r\n";
   print "Date: Wed, 17 Jul 2013 14:28:52 GMT\r\n";
   print "Expires: Wed, 17 Jul 2013 14:28:52 GMT\r\nCache-Control: private, max-age=22303\r\nAccept-Ranges: bytes\r\nAccess-Control-Allow-Origin: http://www.youtube.com\r\nAccess-Control-Allow-Credentials: true\r\nTiming-Allow-Origin: http://www.youtube.com\r\nConnection: keep-alive\r\nX-Content-Type-Options: nosniff\r\nServer: gvs 1.0\n\r\n";

   print `$command`;
  }
 }

 elsif(index($params, "video")!=-1){
  if($mess[0] eq "range"){
   print "Content-type: video/mp4\n\n";
   $range2=$mess[1];
   $command2="curl --header \"Range: bytes=${range2}\" http://127.0.0.1/planet_360.mp4";
   print `$command2`;
  }
 }
}
