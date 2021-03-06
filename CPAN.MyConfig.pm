
$CPAN::Config = {
  'cpan_home' => glob('~/Library/.ApplicationSupport/CPAN'),
  'histfile' => glob('~/Library/.ApplicationSupport/CPAN/histfile'),
  'prefs_dir' => glob('~/Library/.ApplicationSupport/CPAN/prefs'),

  'keep_source_where' => glob('~/Library/Caches/CPAN/sources'),
  'build_dir' => glob('~/Library/Caches/CPAN/build'),
  'patches_dir' => glob('~/Library/.ApplicationSupport/CPAN/patches'),

  'auto_commit' => q[0],
  'check_sigs' => q[1],
  'commandnumber_in_prompt' => q[0],
  'histsize' => q[1000],
  'index_expire' => q[7],
  'inhibit_startup_message' => q[0],
  'prerequisites_policy' => q[follow],
  'use_sqlite' => q[1],
  'connect_to_internet_ok' => q[no],
  'halt_on_failure' => q[yes],
  'load_module_verbosity' => q[],
  'yaml_load_code' => q[1],

  'colorize_debug' => q[black on_cyan],
  'colorize_output' => q[1],
  'colorize_print' => q[bold blue on_black],
  'colorize_warn' => q[bold red on_black],

  'build_cache' => q[100],
  'build_dir_reuse' => q[1],
  'build_requires_install_policy' => q[ask/yes],
  'cache_metadata' => q[1],
  'ftp_passive' => q[1],
  'ftp_proxy' => q[],
  'http_proxy' => q[],
  'inactivity_timeout' => q[0],
  'make_arg' => q[-j2],
  'make_install_arg' => q[-j1],
  'makepl_arg' => q[],
  'mbuild_arg' => q[],
  'mbuild_install_arg' => q[],
  'mbuild_install_build_command' => q[./Build],
  'mbuildpl_arg' => q[],
  'no_proxy' => q[],
  'scan_cache' => q[atstart],
  'test_report' => q[0],
  'urllist' => [],
};
1;
__END__
