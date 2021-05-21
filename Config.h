/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, IQMenu appears at bottom */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] =
{
    "monospace:size=10",
    "JoyPixels:pixelsize=8:antialias=true:autohint=true"
};

static const unsigned int bgalpha = 0xe0;
static const unsigned int fgalpha = OPAQUE;
static const char *prompt = NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] =
{
    /*     fg         bg       */
    [SchemeNorm] = {"#bbbbbb", "#1A1C23"},
    [SchemeSel] = {"#eeeeee", "#21BFC2"},
    [SchemeOut] = {"#000000", "#00ffff"},
};
static const unsigned int alphas[SchemeLast][2] =
{
    /*		fgalpha		bgalphga	*/
    [SchemeNorm] = {fgalpha, bgalpha},
    [SchemeSel] = {fgalpha, bgalpha},
    [SchemeOut] = {fgalpha, bgalpha},
};

/* -l option; if nonzero, IQMenu uses vertical list with given number of lines */
static unsigned int lines = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
