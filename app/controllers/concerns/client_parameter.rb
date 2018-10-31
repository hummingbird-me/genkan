module ClientParameter
  def client
    @client ||= Client.find_by!(key: params[:client_id])
  rescue ActiveRecord::RecordNotFound
    raise OAuth2Error::InvalidClient
  end
end
