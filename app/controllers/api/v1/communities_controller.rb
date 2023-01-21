module Api
  module V1
    class CommunitiesController < ApplicationController
      before_action :authenticate, only: %i[create update]

      def index
        @communities = Community.all
        render_resource(@communities)
      end

      def show
        @community = Community.friendly.find(params['id'])
        render_resource(@community)
      end

      def create
        # Create community and set the creator (current account) as the admin
        @community = Community.new(community_params)
        @community.memberships.build(account_id: current_account.id, role: 'admin')

        # If save successul render community, else render errors
        if @community.save
          render_resource(@community)
        else
          unprocessable_entity(@community)
        end
      end

      def update
        @community = Community.friendly.find(params['id'])

        if @community.update(community_params)
          render_resource(@community)
        else
          unprocessable_entity(@community)
        end
      end

      private

      def community_params
        params.require(:community).permit(:sub_dir, :title, :description)
      end
    end
  end
end
