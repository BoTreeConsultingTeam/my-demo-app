class CityNameController < ApplicationController
  def index
      @citys = CityName.all
    end

    def show
    end

    def new
      @city = CityName.new
    end

    def edit
    end
    def create
      @city = CityName.new(city_params)

      respond_to do |format|
        if @city.save
          format.html { redirect_to @city, notice: 'city was successfully created.' }
          format.json { render :show, status: :created, location: @city }
        else
          format.html { render :new }
          format.json { render json: @city.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @city.update(city_params)
          format.html { redirect_to @city, notice: 'city was successfully updated.' }
          format.json { render :show, status: :ok, location: @city }
        else
          format.html { render :edit }
          format.json { render json: @city.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @city.destroy
      respond_to do |format|
        format.html { redirect_to citys_url, notice: 'city was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def city_params
        params.require(:city_names).permit(:city)
      end
end
