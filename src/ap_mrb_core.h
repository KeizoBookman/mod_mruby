#ifndef AP_MRB_UTILS_H
#define AP_MRB_UTILS_H

#ifndef _WIN32
#include <unistd.h>
#include <string.h>
#include <sys/syslog.h>
#else
#include <string.h>
#endif
#include "mruby.h"

#include "http_protocol.h"
#include "mruby/string.h"


#define INVALID_PRIORITY    -1

//int mod_mruby_return_code;

typedef struct _code {
    char    *c_name;
    int c_val;
} CODE;

int ap_mrb_get_status_code();
int ap_mrb_set_status_code(int val);
void ap_mrb_raise_file_error(mrb_state *mrb, mrb_value obj, request_rec *r, const char *file);
void ap_mrb_raise_file_error_nr(mrb_state *mrb, mrb_value obj, const char *file);
void ap_mrb_raise_error(mrb_state *mrb, mrb_value obj, request_rec *r);
mrb_value ap_mrb_return(mrb_state *mrb, mrb_value self);
mrb_value ap_mrb_get_mod_mruby_version(mrb_state *mrb, mrb_value str);
mrb_value ap_mrb_get_apache_version(mrb_state *mrb, mrb_value str);
mrb_value ap_mrb_sleep(mrb_state *mrb, mrb_value str);
mrb_value ap_mrb_errlogger(mrb_state *mrb, mrb_value str);
mrb_value ap_mrb_syslogger(mrb_state *mrb, mrb_value str);
mrb_value ap_mrb_rputs(mrb_state *mrb, mrb_value str);

#endif
