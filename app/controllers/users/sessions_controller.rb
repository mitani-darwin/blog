class Users::SessionsController < ActionController::Base
  # 正しいDeviseのコールバックをスキップ
  skip_before_action :verify_authenticity_token, only: [:magic_link_login]

  def send_magic_link
    email = params.dig(:user, :email)

    # メールアドレスを取得
    if email.blank?
      flash[:alert] = "メールアドレスを入力してください"
      redirect_to new_session_path and return
    end
    user = User.find_by(email: email)

    token = SecureRandom.hex(10)

    if user
      # 既存データの場合はトークン生成してメール送信
      magic_link = Rails.application.routes.url_helpers.magic_login_url(token: token) # リンク生成
      UserMailer.magic_link_email(user.email, magic_link).deliver_now
      flash[:notice] = "ログイン用リンクを送信しました。メールをご確認ください。"
    else

      # 未登録の場合、仮登録 → トークン生成しメール送信
      user = User.create(
        email: email,
        magic_link_token: token,
        magic_link_token_sent_at: Time.current
      )
      user.save
      magic_link = Rails.application.routes.url_helpers.magic_login_url(token: token) # リンク生成
      UserMailer.magic_link_email(user.email, magic_link).deliver_later
      flash[:alert] = "登録されていないメールアドレスでしたので、仮登録のご案内メールを送信しました。"
    end

    redirect_to new_user_session_path
  end

  def magic_link_login
    # トークンを検索
    user = User.find_by(magic_link_token: params[:token])

    if user && user.magic_link_token_sent_at > 15.minutes.ago
      # トークンは有効、ログイン処理
      user.update!(magic_link_token: nil) # トークンを無効化
      sign_in user
      flash[:notice] = "ログインしました！"
      redirect_to root_path
    else
      # トークン無効化または期限切れ
      flash[:alert] = "リンクは無効化されているか、期限切れです。再度お試しください。"
      redirect_to new_user_session_path
    end
  end

end