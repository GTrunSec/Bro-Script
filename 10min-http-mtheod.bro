event bro_init() 
{      
        local r1 = SumStats::Reducer($stream="http.method", $apply=set(SumStats::TOPK),$topk_size=50);        

        SumStats::create([$name="http_method",                        
            $epoch=10min,                        
            $reducers=set(r1),                        
            $epoch_result(ts: time, key: SumStats::Key, result: SumStats::Result) =                          
        {                          
        local r = result["http.method"];
        local s: vector of SumStats::Observation;
        s=topk_get_top(r$topk,10);
        for (i in s)
        {
            print fmt("HTTP %s,%d",s[i]$str,topk_count(r$topk,s[i]));
        }
        }]);   
}    

event http_request(c: connection, method: string, original_URI: string, unescaped_URI: string, version: string)  
{      
 SumStats::observe("http.method",[],[$str=method]);
}

