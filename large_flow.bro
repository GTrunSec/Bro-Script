@load base/frameworks/notice
module HTTP;

export{
    redef enum Notice::Type += {
    Large_HTTP_Flow,
    };
    const bad_len = 100000 &redef;
}

event connection_state_remove(c: connection){

    if (! c?$http)
    {
        return;
    }
    for ( host in set(c$id$orig_h, c$id$resp_h))
    {
        if (c$http?$response_body_len && c$http$response_body_len >= bad_len) 
        {
        NOTICE([$note=Large_HTTP_Flow,
        $msg=fmt("%s (%s) to %s bad response_body_len of %d",
        host,
        Site::is_local_addr(host) ? "local" : "remote",
        host == c$id$orig_h ? "client" : "server",
        c$http$response_body_len),
        $conn = c]);    
        }
    }
}
