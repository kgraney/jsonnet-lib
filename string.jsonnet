{
    string_to_int(s)::
        local char_to_int(c) = std.codepoint(c) - std.codepoint("0");
        local digits = std.map(char_to_int, std.stringChars(s));
        std.foldr(function(x,y) x+y,
                  std.makeArray(std.length(digits),
                                function(x) digits[std.length(digits)-x-1]*std.pow(10, x)),
                  0),
}
