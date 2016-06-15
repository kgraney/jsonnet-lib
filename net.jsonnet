local string = import "string.jsonnet";

{
    ip_to_int(ip)::
        local parts = std.split(ip, ".");
        local iparts = std.map(string.string_to_int, parts);
        std.foldr(function(x,y) x+y,
                  std.makeArray(std.length(parts),
                                function(x) iparts[x] << 8*(std.length(parts)-x-1)),
                  0),
    int_to_ip(int)::
        std.join(".", std.makeArray(4, function(x) int >> 8*(4-x-1) & 255)),

    cidr_to_list(cidr)::
        local s = std.split(cidr, "/");
        local mask = ~(std.pow(2, 32)-1 >> string.string_to_int(s[1]));
        local start = $.ip_to_int(s[0]) & mask;
        local end = start + ~mask;
        std.map($.int_to_ip, std.range(start, end)),

    cidrs_to_list(cidrs)::
        std.uniq(std.sort(std.flattenArrays(std.map($.cidr_to_list, cidrs)))),
}
