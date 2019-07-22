/**
 * @name Jump-to-definition links
 * @description Generates use-definition pairs that provide the data
 *              for jump-to-definition in the code viewer.
 * @kind definitions
 * @id java/jump-to-definition
 */

import java
import Definitions

external predicate selectedSourceFile(string file);

cached
string getSAName(File f) {
	result = f.getAbsolutePath().replaceAll(":", "_").regexpReplaceAll("^/", "")
}

predicate goodFile(File f) {
    selectedSourceFile(getSAName(f))
}


from Element e, Element def, string kind
where
  def = definition(e, kind) and
  def.fromSource() and
  e.fromSource() and
  not dummyVarAccess(e) and
  not dummyTypeAccess(e)
  and goodFile(e.getFile())
select e, def, kind
