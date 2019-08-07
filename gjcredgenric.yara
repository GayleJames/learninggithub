/**
 * Credential Generic
 * ----
 * This YARA rule is intended to assist with matching generic credential or key
 * leads based on key / value style pattern matches. This is likely to be quite
 * error prone, and represents a last-ditch effort to catch exposures.
 *
 * As always, this should be used as part of a multi-step dispositioning process
 * in order to increase fidelity of reports.
 */
rule CredentialGeneric {
    meta:
        score = "0.5"

    strings:
        // NOTE: DO NOT USE '\s' to match whitespace. This character class
        //       includes both verical and horizontal spaces. This means that
        //       NEW-LINE characters would be matched by this class.
        //$password = /(secret|password)( |\t)*?=( |\t)+?("|')*?[^\n"']+?("|')*?( |\t)*?[\n]+?/ nocase wide ascii
        //anything 'password or secret' inside quotes
        //  $re1 = /(secret|password|pswd|passwd)( |\t)*?=( |\t)*?[^%|*](\"|')\S+?(\"|') / nocase wide ascii
          $re1 = /(secret|password|pswd|passwd)( |\t)*?=( |\t)*?("|')\S+?("|')/ nocase wide ascii
        //  $password2 = /(secret|password)[ =\t]?["'](true|false);?/ nocase wide ascii
          $re2 = /(secret|password)( |\t)*?=( |\t)*?(false|true)/ nocase wide ascii
          //$re3 = /(secret|password)( |\t)*?=( |\t)*?([^"'\W][a-zA-z])/ nocase wide ascii
          $re4 = /(secret|password|passwd|pswd)( |\t)*?=( |\t)*?[^%]("|')\S+?("|')/ nocase wide ascii
          $re5 = /(secret|password)( |\t)*?=( |\t)*?([\w])+([\W])* / nocase wide ascii
        // password or secret followed by an unquoted word that is not true or false
        // $re6 = /(secret|password)( |\t)*?=( |\t)*?(?!false)(?!true)([^"'\W][\w]*)/ nocase wide ascii
        // $reg6 = /(secret|password|pswd|passwd)( |\t)*?=( |\t)*?(?!null)(?!shift)(?!getpass)(?!false)(?!true)([^"'\W]+[\w]*)/ nocase wide ascii
          $re6 = /(secret|password|pswd|passwd)( |\t)*?=( |\t)*?(?!null)(?!shift)(?!getpass)(?!false)(?!true)([^"'\W][\w]*)/ nocase wide ascii
          (secret|password)( |\t)*?=( |\t)*?([^"'\W][a-zA-Z]) // this find variable names not surrounded by quote marks 


    condition:
        // for any i in (1..#password - 1) : ( int32(@password[i]) != int32(0x3C) ) 
        //$re1 or $re3 or $re5 or $re4 and not $re2
        $re1 or $re6