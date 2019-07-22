/**
 * @name Jump-to-definition links
 * @description Generates use-definition pairs that provide the data
 *              for jump-to-definition in the code viewer.
 * @kind definitions
 * @id cs/jump-to-definition
 */

import csharp
import definitions

external predicate selectedSourceFile(string file);

cached
string getSAName(File f) {
	result = f.getAbsolutePath().replaceAll(":", "_").regexpReplaceAll("^/", "")
}
predicate goodLocation(string s) {
  selectedSourceFile(getSAName(any(File f | f.getAbsolutePath() = s)))
}

from Use use, Declaration definition, string type
where
  defs(use,definition, type)
  and use.hasLocationInfo(any(string s | goodLocation(s)),_,_,_,_)
select use, definition, type
