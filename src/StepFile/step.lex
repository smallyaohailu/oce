/* 
 Copyright (c) 1999-2014 OPEN CASCADE SAS

 This file is part of Open CASCADE Technology software library.

 This library is free software; you can redistribute it and/or modify it under
 the terms of the GNU Lesser General Public License version 2.1 as published
 by the Free Software Foundation, with special exception defined in the file
 OCCT_LGPL_EXCEPTION.txt. Consult the file LICENSE_LGPL_21.txt included in OCCT
 distribution for complete text of the license and disclaimer of any warranty.

 Alternatively, this file may be used under the terms of Open CASCADE
 commercial license or contractual agreement.
*/ 

%{
#include "step.tab.h"
#include "recfile.ph"
#include "stdio.h"
#include <StepFile_CallFailure.hxx>

/* skl 31.01.2002 for OCC133(OCC96,97) - uncorrect
long string in files Henri.stp and 401.stp*/
#define YY_FATAL_ERROR(msg) StepFile_CallFailure( msg )

/* abv 07.06.02: force inclusion of stdlib.h on WNT to avoid warnings */
#ifdef _MSC_VER
// add includes for flex 2.91 (Linux version)
#include <stdlib.h>
#include <io.h>

// Avoid includion of unistd.h if parser is generated on Linux (flex 2.5.35)
#ifndef YY_NO_UNISTD_H
#define YY_NO_UNISTD_H
#endif

// disable MSVC warnings in flex 2.89 and 2.5.35 code
// Note that Intel compiler also defines _MSC_VER but has different warning ids
#if defined(__INTEL_COMPILER)
#pragma warning(disable:177 1786 1736)
#elif defined(__clang__)
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Winconsistent-dllimport"
#pragma GCC diagnostic ignored "-Wunneeded-internal-declaration"
#else
#pragma warning(disable:4131 4244 4273 4127 4267)
#endif

#endif /* MSC_VER */

/*
void steperror ( FILE *input_file );
void steprestart ( FILE *input_file );
*/
void rec_restext(char *newtext, int lentext);
void rec_typarg(int argtype);
 
 /* Counter of lines in the file  */
int  steplineno;
  
/* Reset the lexical scanner before reading */
void rec_inityyll()
{ 
  yy_init  = yy_start = 1;  
}

/* Record current match (text string) for further processing */
void resultat()
{ 
  rec_restext(yytext,yyleng);
}

// disable GCC warnings in flex code
#ifdef __GNUC__
#pragma GCC diagnostic ignored "-Wunused-function"
#endif

%}
%x Com End Text
%%
"/*"               { BEGIN(Com); }     /* start of comment - put the scanner in the "Com" state */
<Com>[^*\n]*       {;}                 /* in comment, skip any characters except asterisk (and newline, handled by its own rule) */
<Com>[*]+[^*/\n]*  {;}                 /* in comment, skip any sequence of asterisks followed by other symbols (except slash or newline) */
<Com>[*]+[/]       { BEGIN(INITIAL); } /* end of comment - reset the scanner to initial state */

[']                { BEGIN(Text); yymore(); }   /* start of quoted text string - put the scanner in the "Text" state, but keep ' as part of yytext */
<Text>[\n]         { yymore(); steplineno ++; } /* newline in text string - increment line counter and keep collecting yytext */
<Text>[']          { yymore(); }                /* single ' inside text string - keep collecting yytext*/
<Text>[^\n']+      { yymore(); }                /* a sequence of any characters except ' and \n - keep collecting yytext */
<Text>[']/[" "\n\r]*[\)\,]    { BEGIN(INITIAL); resultat(); rec_typarg(rec_argText); return(QUID); } /* end of string (apostrophe followed by comma or closing parenthesis) - reset the scanner to initial state, record the value of all yytext collected */

"	"	{;}
" "		{;}
<*>[\n]		{ steplineno ++; } /* count lines (one rule for all start conditions) */
[\r]    	{;} /* abv 30.06.00: for reading DOS files */
[\0]+		{;} /* fix from C21. for test load e3i file with line 15 with null symbols */

#[0-9]+/=		{ resultat(); return(ENTITY); }
#[0-9]+/[ 	]*=	{ resultat(); return(ENTITY); }
#[0-9]+		{ resultat(); return(IDENT); }
[-+0-9][0-9]*	{ resultat(); rec_typarg(rec_argInteger); return(QUID); }
[-+\.0-9][\.0-9]+	{ resultat(); rec_typarg(rec_argFloat); return(QUID); }
[-+\.0-9][\.0-9]+E[-+0-9][0-9]*	{ resultat(); rec_typarg(rec_argFloat); return(QUID); }
["][0-9A-F]+["] 	{ resultat(); rec_typarg(rec_argHexa); return(QUID); }
[.][A-Z0-9_]+[.]	{ resultat(); rec_typarg(rec_argEnum); return(QUID); }
[(]		{ return ('('); }
[)]		{ return (')'); }
[,]		{ return (','); }
[$]		{ resultat(); rec_typarg(rec_argNondef); return(QUID); }
[=]		{ return ('='); }
[;]		{ return (';'); }

STEP;		{ return(STEP); }
HEADER;		{ return(HEADER); }
ENDSEC;		{ return(ENDSEC); }
DATA;		{ return(DATA); }
ENDSTEP;	{ return(ENDSTEP);}
"ENDSTEP;".*	 { return(ENDSTEP);}
END-ISO[0-9\-]*; { BEGIN(End); return(ENDSTEP); } /* at the end of the STEP data, enter dedicated start condition "End" to skip everything that follows */
ISO[0-9\-]*;	 { return(STEP); }

[/]		{ return ('/'); }
&SCOPE		{ return(SCOPE); }
ENDSCOPE	{ return(ENDSCOPE); }
[a-zA-Z0-9_]+	{ resultat(); return(TYPE); }
![a-zA-Z0-9_]+	{ resultat(); return(TYPE); }
[^)]		{ resultat(); rec_typarg(rec_argMisc); return(QUID); }

<End>[^\n]      {;} /* skip any characters (except newlines) */
