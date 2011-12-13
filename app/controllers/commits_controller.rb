class CommitsController < ApplicationController
  before_filter :verify_ownership, :only => [:destroy]

  # GET /commits
  def index
    @commits = Commit.order("updated_at DESC").page(params[:page] || 1)
  end

  def archive
    @commits = Commit.where(:closed => true).order("updated_at DESC").page(params[:page] || 1).per(10)

    render :index
  end

  # GET /commits/1
  def show
    @commit = Commit.find(params[:id])
    @voice = Voice.new
  end

  # GET /commits/new
  def new
    @commit = Commit.new
  end

  # GET /commits/1/edit
  def edit
    @commit = Commit.find(params[:id])
  end

  # POST /commits
  # POST /commits.xml
  def create
    @commit = Commit.new(params[:commit])
    @commit.user = current_user

    respond_to do |format|
      if @commit.save
        format.html { redirect_to(@commit, :notice => 'Commit was successfully created.') }
        format.xml  { render :xml => @commit, :status => :created, :location => @commit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @commit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /commits/1
  def update
    @commit = Commit.find(params[:id])

    if @commit.update_attributes(params[:commit])
      redirect_to @commit, :notice => 'Commit was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /commits/1
  def destroy
    @commit.destroy

    redirect_to commits_url
  end

  private

    def verify_ownership
      @commit = Commit.find(params[:id])

      if current_user != @commit.user
        flash.now.alert = "Sorry, this isn't your commit!"
        return false
      else
        return true
      end
    end
end
