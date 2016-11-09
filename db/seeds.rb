# Creates super admin
User.create(
  full_name: 'Super Admin',
  email: 'super@admin.com',
  login: 'super_admin',
  password: 'super_admin',
  position: 'admin',
  role: 'admin'
)

# Creates services: upwork, guru
Service.create(
  [
    {
      name: 'Upwork',
      url: 'https://www.upwork.com/ab/account-security/login',
      login_button_identifier: '[type="submit"]',
      login_field_identifier: '#login_username'
    },
    {
      name: 'Guru',
      url: 'https://www.guru.com/login.aspx',
      login_button_identifier: '#ctl00_ContentPlaceHolder1_btnLoginAccount_btnLoginAccount_Button',
      login_field_identifier: '#ctl00_ContentPlaceHolder1_ucLogin_txtUserName_txtUserName_TextBox'
    }
  ]
)
