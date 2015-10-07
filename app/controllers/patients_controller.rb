class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all

    respond_with(@patients)
  end

  def show
    respond_with(@patient)
  end

  def new
    @patient = Patient.new

    respond_with(@patient)
  end

  def edit; end

  def create
    @patient = Patient.new(patient_params)
    @patient.save

    respond_with(@patient, location: patients_url)
  end

  def update
    @patient.update(patient_params)

    respond_with(@patient, location: patients_url)
  end

  def destroy
    @patient.destroy

    respond_with(@patient)
  end

  def find_address
    @address = BuscaEndereco.cep(params[:zip_code])

    respond_with(@address)
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :email, :address, :state, :city, :id,
                                    :zip_code, :district, :number, :phone, :current_step,
                                    :cellphone, basic_treatment_ids: [],
                                    appointments_attributes: [:attend_at, :kind, :id, :status])
  end
end
