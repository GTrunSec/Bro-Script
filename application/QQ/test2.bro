#@load misc/dump-events

@load base/frameworks/software

export {
    redef enum Software::Type += {
        
        QQ_PC,
        QQ_Mobile,
        QQ,
		};

}
redef record Software::Info  += {
    QQ_num: string &optional &log;
};

event http_header(c: connection, is_orig: bool, name: string, value: string) &priority=2
{
	local qq: Software::Info;
    	if ( is_orig )
        {
       	 	if ( name == "USER-AGENT" )
            	{
			#Get Mobile QQ app's version  
			#value: [Mozilla/5.0 (Linux; Android 6.0; Redmi Pro Build/MRA58K; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/53.0.2785.49 Mobile MQQBrowser/6.2 TBS/043610 Safari/537.36 V1_AND_SQ_7.0.0_676_YYB_D PA QQ/7.0.0.3135 NetType/WIFI WebP/0.3.0 Pixel/1080]
			if (/PA QQ/ in value)
			{
				local paqqstr = split_string_all(value, /PA QQ\//);
				local qq_version = split_string_all(paqqstr[2],/NetType/);
				local version1 = strip(qq_version[0]);
				local ver_vec: vector of string = split_string(version1, /\./);
				print ver_vec;

				if (/NetType\/WIFI/ in value)
				{
					qq$software_type = QQ_Mobile;
				}
               	qq = [$host=c$id$resp_h, $host_p=c$id$resp_p,$version=[$major=to_count(ver_vec[0]),$minor=to_count(ver_vec[1]),$minor2=to_count(ver_vec[2]),$minor3=to_count(strip(ver_vec[3])),$addl=qq_version[0]]];
				#print qq;
                Software::found(c$id, qq);
			}

              		if (/uin/ in c$http$uri)
              		{
               			local temp = split_string_all(c$http$uri,/^\uin=/);
               			temp = split_string_all(temp[2],/\&/);
               			qq$QQ_num = temp[0];
           		}         
#               		qq = [$host=c$id$resp_h, $host_p=c$id$resp_p];
#			print qq;
#                	Software::found(c$id, qq);
        	}
    		else
        	{
        		if ( name == "QQ_Mobile" )
			{
            			qq = [$software_type = QQ_Mobile, $unparsed_version=value, $host=c$id$resp_h, $host_p=c$id$resp_p];
				
				#print qq;
               		 	#Software::found(c$id, qq);
        		}
			else if ( name == "QQ_CLIENT" )
			{
           	 		qq = [$software_type=QQ, $unparsed_version=value, $host=c$id$resp_h, $host_p=c$id$resp_p];
				#print qq;
                		#Software::found(c$id, qq);
    			}
       	 	}
    	}
}
