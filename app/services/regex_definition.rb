module RegexDefinition

  REG_ALPHA = /[a-zA-Z]+/
  REG_ALPHA_NUM = /[a-zA-Z0-9]+/
  REG_NUM = /[0-9]+/

  REG_EMAIL =/\A[a-zA-Z0-9_#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/

  REG_HANKAKU_EISU_WITH_ALL_MARK_WITHOUT_SPACE = Regexp.new(/\A[!-~]+\z/)

end