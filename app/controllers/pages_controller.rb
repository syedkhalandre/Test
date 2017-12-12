class PagesController < ApplicationController
  #before_filter :find_page,:only => [:edit,:update,:delete,:show]
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject
  def index
    @pages = @subject.pages.all
  end

  def show
    @page = Page.find(params[:id]) #rescue nil
  end

  def new
    @page = Page.new({:subject_id => @subject_id})
    @page_count = Page.count + 1
    @subject = Subject.order("position ASC")
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(:action => 'index', :subject_id => @subject_id)
    else
      @page_count = Page.count + 1
      @subject = Subject.order("position ASC")
      render('new')

    end
  end

  def edit
  @page = Page.find(params[:id])
  @page_count = Page.count
  @subject = Subject.order("position ASC")
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject_id)
    else
      @page_count = Page.count
      @subject = Subject.order("position ASC")
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page destroyed successfully."
    redirect_to(:action => 'index', :subject_id => @subject_id)
  end


  private

    def page_params
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
    end
     
     def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
     end
    # def find_page
    #   @page = Page.find(params[:id])
    # rescue ActiveRecordNotfound
    #   render_404
    # end

end
