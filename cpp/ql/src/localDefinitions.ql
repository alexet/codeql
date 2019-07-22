/**
 * @name Jump-to-definition links
 * @description Generates use-definition pairs that provide the data
 *              for jump-to-definition in the code viewer.
 * @kind local-definitions
 * @id cpp/local-jump-to-definition
 */

import definitions

external predicate selectedSourceFile(string file);

cached
string getSAName(File f) {
	result = f.getAbsolutePath().replaceAll(":", "_").regexpReplaceAll("^/", "")
}
predicate goodLocation(Location l) {
  selectedSourceFile(getSAName(l.getFile()))
}

from Top e, Top def, string kind
where
  def = definitionOf(e, kind) and
  goodLocation(e.getLocation())
select e, def, kind
