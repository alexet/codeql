/**
 * @name Jump-to-definition links
 * @description Generates use-definition pairs that provide the data
 *              for jump-to-definition in the code viewer.
 * @kind definitions
 * @id js/jump-to-definition
 */

import javascript
private import Definitions

external predicate selectedSourceFile(string file);

cached
string getSAName(File f) {
	result = f.getAbsolutePath().replaceAll(":", "_").regexpReplaceAll("^/", "")
}
predicate goodLocation(Location l) {
  selectedSourceFile(getSAName(l.getFile()))
}

cached predicate allDefs(ASTNode ref, ASTNode decl, string kind) {
    variableDefLookup(ref, decl, kind)
    or
    // prefer definitions over declarations
    not variableDefLookup(ref, _, _) and variableDeclLookup(ref, decl, kind)
    or
    importLookup(ref, decl, kind)
    or
    propertyLookup(ref, decl, kind)
    or
    typeLookup(ref, decl, kind)
    or
    typedInvokeLookup(ref, decl, kind)
	
}



from ASTNode ref, ASTNode decl, string kind
where
  (allDefs(ref,decl, kind)) and
  goodLocation(ref.getLocation())
select ref, decl, kind
