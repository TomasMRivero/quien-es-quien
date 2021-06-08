class Personaje
    attr_accessor :nombre, :genero, :pelado, :pelo_largo, :color_pelo, :vello_facial, :barba, :bigote, :sombrero, :labios_gruesos, :anteojos, :mejillas_coloradas, :ojos_celestes, :sonrie, :nariz_grande
    def initialize(nombre, genero, pelado, pelo_largo, color_pelo, vello_facial, barba, bigote, sombrero, labios_gruesos, anteojos, mejillas_coloradas, ojos_celestes, sonrie, nariz_grande)
        @nombre = nombre
        @genero = genero
        @pelado = pelado
        @pelo_largo = pelo_largo
        @color_pelo = color_pelo
        @vello_facial = vello_facial
        @barba = barba
        @bigote = bigote
        @sombrero = sombrero
        @labios_gruesos = labios_gruesos
        @anteojos = anteojos
        @mejillas_coloradas = mejillas_coloradas
        @ojos_celestes = ojos_celestes
        @sonrie = sonrie
        @nariz_grande = nariz_grande
    end
end

array_personajes = Array.new

begin
    file = File.open("personajes.txt", "r")
        for line in file.readlines()
            elemento = line.strip().split(';')
            for i in 1..elemento.length-1
                if elemento[i] == 'true'
                    elemento[i] = true
                elsif elemento[i] == 'false'
                    elemento[i] = false
                end
            end
            new_personaje = Personaje.new(*elemento)
            array_personajes.push(new_personaje)
        end
    end
    file.close
rescue Errno::ENOENT
    puts "No se encontró el archivo"
rescue => e
    puts e
end