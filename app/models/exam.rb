class Exam < ApplicationRecord
  include Sortable

  belongs_to :unit, optional: true

  has_many :exam_result, dependent: :restrict_with_error
  has_many :result, through: :exam_result
  has_many :exam_reference, dependent: :delete_all
  has_many :reference, through: :exam_reference
  # accepts_nested_attributes_for :valor, allow_destroy: true, reject_if: :all_blank

  # delegate :name, to: :unit, prefix: true, allow_nil: true

  validates :name, presence: true, uniqueness: {
    case_sensitive: false, scope: %i[ancestry unit_id]
  }

  # scope :ordered, lambda {
  #   select(:id, :name, :unit_id)
  #     .includes(:unit)
  #     .order(:name)
  # }

  # def valor_referencia_extenso(idade, sexo)
  #   valor = valor_referencia(idade, sexo)
  #   return '' if valor.nil?

  #   retorno = '|'
  #   retorno += " Sexo: #{ valor.gender } |" unless valor.gender.blank?

  #   if valor.idade_inferior and valor.idade_superior
  #     retorno += " Idade: #{ valor.idade_inferior.to_i } ~ #{ valor.idade_superior.to_i } anos |"
  #   elsif valor.idade_inferior and valor.idade_superior.nil?
  #     retorno += " Idade acima de: #{ valor.idade_inferior.to_i } anos |"
  #   elsif valor.idade_inferior.nil? and valor.idade_superior
  #     retorno += " Idade abaixo de: #{ valor.idade_superior.to_i } anos |"
  #   end

  #   if valor.valor_inferior and valor.valor_superior
  #     retorno += " Valor: #{ valor.valor_inferior } ~ #{ valor.valor_superior } |"
  #   elsif valor.valor_inferior and !valor.valor_superior
  #     retorno += " Valor acima de: #{ valor.valor_inferior } |"
  #   elsif !valor.valor_inferior and valor.valor_superior
  #     retorno += " Valor abaixo de: #{ valor.valor_superior } |"
  #   end

  #   retorno += "Referência: #{ valor.reference.name } |" unless valor.reference.blank?

  #   retorno == '|' ? '' : retorno
  # end

  # def valor_referencia(idade, sexo)
  #   retorno = nil

  #   return retorno if idade.nil?

  #   self.valor.each do |valor|
  #     next if !valor.valido?

  #     if valor.idade_inferior and valor.idade_superior
  #       if idade >= valor.idade_inferior and idade <= valor.idade_superior
  #         return valor if valida_sexo(valor, sexo)
  #       end
  #     elsif valor.idade_inferior and valor.idade_superior.nil?
  #       if idade >= valor.idade_inferior
  #         return valor if valida_sexo(valor, sexo)
  #       end
  #     elsif valor.idade_inferior.nil? and valor.idade_superior
  #       if idade <= valor.idade_superior
  #         return valor if valida_sexo(valor, sexo)
  #       end
  #     else
  #       return valor if valida_sexo(valor, sexo)
  #     end
  #   end

  #   retorno
  # end

  # private
  # def valida_sexo(valor, sexo)
  #   if valor.gender.blank? or valor.gender == sexo
  #     return true
  #   end

  #   false
  # end

  def self.sort_by
    %w[name]
  end

  private_class_method :sort_by
end
