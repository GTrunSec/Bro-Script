function filter_pred(rec: HTTP::Info): bool
{
if( rec?$referrer)
  return T;
  return F;
  }

event bro_init() &priority=-10 {
  local filt = Log::get_filter(HTTP::LOG, "default");
  filt$exclude = set("info_code","referrer");
  Log::add_filter(HTTP::LOG, filt);
}
