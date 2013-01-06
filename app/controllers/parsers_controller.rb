class ParsersController < ApplicationController
  # GET /parsers
  # GET /parsers.json
  def index
    @parsers = Parser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parsers }
    end
  end

  # GET /parsers/1
  # GET /parsers/1.json
  def show
    @parser = Parser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parser }
    end
  end

  # GET /parsers/new
  # GET /parsers/new.json
  def new
    @parser = Parser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parser }
    end
  end

  # GET /parsers/1/edit
  def edit
    @parser = Parser.find(params[:id])
  end

  # POST /parsers
  # POST /parsers.json
  def create
    @parser = Parser.new(params[:parser])

    respond_to do |format|
      if @parser.save
        format.html { redirect_to @parser, notice: 'Parser was successfully created.' }
        format.json { render json: @parser, status: :created, location: @parser }
      else
        format.html { render action: "new" }
        format.json { render json: @parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parsers/1
  # PUT /parsers/1.json
  def update
    @parser = Parser.find(params[:id])

    respond_to do |format|
      if @parser.update_attributes(params[:parser])
        format.html { redirect_to @parser, notice: 'Parser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /parsers/upload
  # POST /parsers/upload.json
  def upload
    unless params[:parsers] && params[:parsers][:file_traveling]
      flash[:error] = "There was an error upload this file... try again!"
      return redirect_to parsers_path
    end

    upload = FileParser.process(params[:parsers][:file_traveling].tempfile)
    @parsers = upload.parsers
  end
  
  # DELETE /parsers/1
  # DELETE /parsers/1.json
  def destroy
    @parser = Parser.find(params[:id])
    @parser.destroy

    respond_to do |format|
      format.html { redirect_to parsers_url }
      format.json { head :no_content }
    end
  end
end
