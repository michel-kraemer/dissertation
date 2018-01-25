start
  = SP* (statements SP*)?

statements
  = statement ( SP+ statement )*

statement
  = with / for / operation

with
  = WITH SP+ dataset SP+ block

for
  = FOR SP+ EACH SP+ dataset SP+ DO SP+ statements (SP+ yield)?
    SP+ END ( SP+ AS SP+ NAME )?

yield
  = YIELD ( SP+ ref )?

operation
  = special_operation / param_operation

special_operation
  = (VISUALIZE / STORE) (SP+ ref)?

param_operation
  = operation_name (SP+ NAME)? operation_with? operation_using?
    operation_as?

operation_name
  = APPLY / CREATE / EXCLUDE / EXTRACT / REMOVE / REORDER / RESAMPLE
  / SPLIT / UPDATE

operation_with
  = SP+ WITH SP+ dataset ( SP+ AND SP+ dataset )*

operation_using
  = SP+ USING SP+ params

operation_as
  = SP+ AS SP+ NAME

block
  = DO SP+ statements SP+ END


dataset
  = placeholder / (RECENT SP+)? ref

params
  = param ( SP+ AND SP+ param )*

param
  = NAME SP* ":" SP* expression

expression
  = NUMBER / string

placeholder
  = "[" NAME "]"

ref
  = objectRef / varRef

objectRef
  = NAME SP* "." SP* ref

varRef
  = NAME

string
  = '"' STRING_CHAR* '"'

KEYWORD
  = AND / APPLY / AS / CREATE / DO / EACH / END / EXCLUDE / EXTRACT
  / FOR / RECENT / REMOVE / REORDER / RESAMPLE / SPLIT / STORE
  / UPDATE / USING / VISUALIZE / WITH / YIELD

NAME           = !KEYWORD [_a-zA-Z] NAME_MORE*
NAME_MORE      = [_a-zA-Z0-9]
NUMBER         = [0-9]+ ( "." [0-9]+ )?
STRING_CHAR    = !["\\\r\n] . / "\\" ESCAPE_CHAR
ESCAPE_CHAR    = ["\\bfnrtv]
COMMENT        = ("#" / "//") (!"\n" .)*
SP             = [ \t\n\r] / COMMENT

AND            = "and"            !NAME_MORE
APPLY          = "apply"          !NAME_MORE
AS             = "as"             !NAME_MORE
CREATE         = "create"         !NAME_MORE
DO             = "do"             !NAME_MORE
EACH           = "each"           !NAME_MORE
END            = "end"            !NAME_MORE
EXCLUDE        = "exclude"        !NAME_MORE
EXTRACT        = "extract"        !NAME_MORE
FOR            = "for"            !NAME_MORE
RECENT         = "recent"         !NAME_MORE
REMOVE         = "remove"         !NAME_MORE
REORDER        = "reorder"        !NAME_MORE
RESAMPLE       = "resample"       !NAME_MORE
SPLIT          = "split"          !NAME_MORE
STORE          = "store"          !NAME_MORE
UPDATE         = "update"         !NAME_MORE
USING          = "using"          !NAME_MORE
VISUALIZE      = "visualize"      !NAME_MORE
               / "visualise"      !NAME_MORE
WITH           = "with"           !NAME_MORE
YIELD          = "yield"          !NAME_MORE
