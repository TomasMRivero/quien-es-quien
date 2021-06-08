no_file = false
personajes = Array.new

preguntas = {
    :genero => "Es hombre o mujer?(H/M): ",
    :pelado => "Es pelado?(S/N): ",
    :pelo_largo => "Tiene pelo largo?(S/N): ",
    :color_pelo => "Indique si tiene pelo blanco, negro, amarillo, rojo o marrón(B/N/A/R/M): ",
    :vello_facial => "Tiene vello facial?(S/N): ",
    :barba => "Tiene barba?(S/N): ",
    :bigote => "Tiene bigote?(S/N): ",
    :sombrero => "Usa sombrero?(S/N): ",
    :labios_gruesos => "Tiene labios gruesos?(S/N): ",
    :anteojos => "Usa anteojos?(S/N): ",
    :mejillas_coloradas => "Tiene las mejillas coloradas?(S/N): ",
    :ojos_celestes => "Tiene ojos celestes?(S/N): ",
    :sonrie => "Está sonriendo?(S/N): ",
    :nariz_grande => "Tiene la nariz grande?(S/N): "
}

def preguntas_descripcion(preguntas, personaje)
    for i in preguntas
    
        case i[0]
        when :genero
            print i[1];
            loop do
                res = gets.strip().upcase()
                if  res[0] == "H" or res[0] == "M"
                    personaje.push(res[0])
                    break
                end
                print "Error. Debe indicar H para hombre o M para mujer: "
            end
        when :pelo_largo
            if personaje.last
                personaje.push(false)
                next
            else
                print i[1];
                loop do
                    res = gets.strip().upcase()
                    if  res[0] == "S" or res[0] == "N"
                        if  res[0] == "S"
                            personaje.push(true)
                        else
                            personaje.push(false)
                        end  
                        break
                    end
                    print "Error. Debe indicar S para si o N para no: "
                end
            end
        when :color_pelo
            print i[1];
            loop do
                res = gets.strip().upcase()
                if  res[0] == "B" or res[0] == "N" or res[0] == "A" or res[0] == "R" or res[0] == "M"
                    personaje.push(res[0])
                    break
                end
                print "Error. Debe indicar la inicial del color(B/N/A/R/M): "
            end
        when :barba, :bigote
            if !personaje[5]
                personaje.push(false)
                next
            else
                print i[1];
                loop do
                    res = gets.strip().upcase()
                    if  res[0] == "S" or res[0] == "N"
                        if  res[0] == "S"
                            personaje.push(true)
                        else
                            personaje.push(false)
                        end  
                        break
                    end
                    print "Error. Debe indicar S para si o N para no: "
                end
            end
        else
            print i[1];
            loop do
                res = gets.strip().upcase()
                if  res[0] == "S" or res[0] == "N"
                    if  res[0] == "S"
                        personaje.push(true)
                    else
                        personaje.push(false)
                    end    
                    break
                end
                print "Error. Debe indicar S para si o N para no: "
            end
        end

    end
end

def nuevo_personaje(personajes, preguntas)
    
    personaje = Array.new

    loop do
        print "Introduzca el nombre del personaje: "
        nombre = gets.chomp()
        if nombre.length() > 0
            personaje.push(nombre)
            break
        else
            print "Debe introducir un nombre.\n"
        end
    end

    
    preguntas_descripcion(preguntas, personaje)
    if !personaje[6] and !personaje[7]
        personaje[5] = false
    end
    personajes.push(personaje)


end


begin
    file = File.open("personajes.txt", "r")
    for line in file.readlines()
        import = line.split(';')
        personaje = Array.new
        for i in import
            i = i.strip()
            if i == "true"
                i = true
            elsif i == "false"
                i = false
            end
            personaje.push(i)
        end
    personajes.push(personaje)
    end
    file.close
rescue Errno::ENOENT
    puts "No se encontró el archivo"
    no_file = true
rescue => e
    puts e
end

nuevo_personaje(personajes, preguntas)
print personajes

begin
    file = File.open("personajes.txt", "w")
    for personaje in personajes
        for i in 0..personaje.length-1 
            if i != personaje.length-1
                file.write("#{personaje[i]};")
            else
                file.write("#{personaje[i]}\n")
            end
        end
    end
    file.close
rescue Errno::ENOENT
    puts "No se encontró el archivo"
    no_file = true
rescue => e
    puts e
end
