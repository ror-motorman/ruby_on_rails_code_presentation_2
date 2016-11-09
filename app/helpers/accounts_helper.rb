module AccountsHelper
  def account_status(account)
    account.user_id? ? t('helpers.status.occupied_by', name: account.user.full_name) : t('helpers.status.free')
  end
end
