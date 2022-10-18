
[1mFrom:[0m /home/kasper/.rbenv/versions/3.1.2/lib/ruby/3.1.0/net/http.rb:1040 Net::HTTP#connect:

    [1;34m1035[0m:         @ssl_context.session_cache_mode =
    [1;34m1036[0m:           [1;34;4mOpenSSL[0m::[1;34;4mSSL[0m::[1;34;4mSSLContext[0m::[1;34;4mSESSION_CACHE_CLIENT[0m |
    [1;34m1037[0m:           [1;34;4mOpenSSL[0m::[1;34;4mSSL[0m::[1;34;4mSSLContext[0m::[1;34;4mSESSION_CACHE_NO_INTERNAL_STORE[0m
    [1;34m1038[0m:         @ssl_context.session_new_cb = proc {|sock, sess| @ssl_session = sess }
    [1;34m1039[0m:         [1;34;4mD[0m [31m[1;31m"[0m[31mstarting SSL for #{conn_addr}[0m[31m:#{conn_port}[0m[31m...[1;31m"[0m[31m[0m
 => [1;34m1040[0m:         binding.pry
    [1;34m1041[0m:         s = [1;34;4mOpenSSL[0m::[1;34;4mSSL[0m::[1;34;4mSSLSocket[0m.new(s, @ssl_context)
    [1;34m1042[0m:         s.sync_close = [1;36mtrue[0m
    [1;34m1043[0m:         [1;34m# Server Name Indication (SNI) RFC 3546[0m
    [1;34m1044[0m:         s.hostname = @address [32mif[0m s.respond_to? [33m:hostname=[0m
    [1;34m1045[0m:         [32mif[0m @ssl_session [32mand[0m

