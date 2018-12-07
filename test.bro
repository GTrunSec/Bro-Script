module NetControl; 

@if ( Cluster::is_enabled() && Cluster::local_node_type() == Cluster::MANAGER )

event NetControl::rule_expire(r: Rule, p: PluginState) &priority=-5
        {
	    local ip = subnet_to_addr(r$entity$ip) ; 
	#Scan::log_reporter(fmt ("acld_rule_expire: Rule: %s", subnet_to_addr(r$entity$ip)),1); 
}