
require "active_model_serializers"
require "active_support/all"

class Pessoa
  # Torna esse model serializável pelo ActiveModel::Serialization
  include ActiveModel::Serialization

  attr_accessor :idade, :altura, :peso

  # Retorna qual classe é responsável pode serializar este model
  def active_model_serializer
    PessoaSerializer
  end
end

class PessoaSerializer < ActiveModel::Serializer
  attributes :idade, :altura, :peso, :imc

  def imc
    altura_em_metros = object.altura.to_f / 100
    imc = object.peso.to_f / (altura_em_metros * altura_em_metros)
    imc.round 2
  end
end

carlos = Pessoa.new #idade: 26, altura: 180, peso: 95
carlos.idade = 26
carlos.altura = 180
carlos.peso = 95
serializer = PessoaSerializer.new carlos, root: false

puts "Como JSON => #{serializer.to_json}"
puts "Como Hash => #{serializer.serializable_hash}"