# Regular Expression (Regex Notes)

## Best Practices
* make the regex as specific as possible
	* best to restrict the start and end of test strings using ^<sequence>$ where possible

## Basics
* [abc] - match any of a, b, c
* [^abc] - match anything BUT a, b, c
* a{n, m} - match between n and m a's
	* ex: a{1, 3} matches a, aa, and aaa, but not aaaa
	* ex: a{3,} matches aaa, aaaa, aaaaa... but not a or aa
* \s - match any whitespace character
* . - match any non-whitespace character
* \w - match any character
* \W - match any non-character
* \d - match any digit
* \D - match any non-digit
* <sequence>+ - match one or more of the preceding sequence
	* ex: [abc]+ matches one or more of a, b, c, so will match aaabbcccc, abc, etc.
* <sequence>* - match zero or more of the preceding sequence
* ? - optionality
	* ex: ab?c matches abc or ac (b is optional)
* ^ - start of the line
	* ex: ^successful matches success but not unsuccessful
* $ - end of the line
	* ex: success* matches success but not successful
* (<sequence>) - captures the group specified in ()
	* ex: (\w+)\.png matches hello.png and captures 'hello'

## Lookarounds
* ?=<sequence> - Lookahead, asserts that <sequence> immediately follows wherever the lookahead is positioned
* ?!<sequence> - Negative Lookahead - asserts that the following sequence doesn't match <sequence>
* ?<=<sequence> - Lookbehind, asserts that <sequence> immediately precedes wherever the lookbehind is positioned
* ?<!<sequence> - Negative Lookbehind - asserts that the preceding sequence doesn't match <sequence>