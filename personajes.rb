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

def pregunta_booleana(preg)
    print preg;
    loop do
        res = gets.strip().upcase()
        if  res[0] == "S" or res[0] == "N"
            if  res[0] == "S"
                return true
            else
                return false
            end    
            break
        end
        print "Error. Debe indicar S para si o N para no: "
    end
end

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
                personaje.push(pregunta_booleana(i[1]));
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
                personaje.push(pregunta_booleana(i[1]));
            end
        else
            personaje.push(pregunta_booleana(i[1]));
        end

    end
end

def nuevo_personaje(personajes, preguntas)
    
    personaje = Array.new

    loop do
        print "Introduzca el nombre del personaje: "
        nombre = gets.strip()
        nombre_es_unico = 1
        if nombre.length() > 0
            for i in personajes
                if nombre.upcase() == i[0].upcase();
                print "Ya existe un personaje con ese nombre. Introduzca otro nombre.\n"
                nombre_es_unico = 0
                break
                end          
            end
            if nombre_es_unico == 1
                personaje.push(nombre)
                break
            end
        else
            print "Debe introducir un nombre.\n"
        end
    end

    
    preguntas_descripcion(preguntas, personaje)
    if !personaje[6] and !personaje[7]
        personaje[5] = false
    end

    es_igual = 0

    for i in personajes
        for j in 1..i.length-1
            if i[j] != personaje[j]
                es_igual = 0
                break
            end
            es_igual = 1
            igual_a = i[0]
        end
        break if es_igual == 1            
    end

    if es_igual == 1
        puts "Tiene las mismas características que #{igual_a}. No se va a guardar."
    else
        personajes.push(personaje)
    end

end

def mostrar_personajes(personajes)

    for i in 0..personajes.length-1
        print "\n" if i%4 == 0
        print "%-3s: %-30s" % [ i, personajes[i][0] ]
    end

end

def mostrar_caracteristicas(personaje, preguntas)
    i = 1
    puts personaje[0].upcase()
    for preg in preguntas
        case personaje[i]
            when true
                res = "Si"
            when false
                res = "No"
            when "B"
                res = "BLANCO"
            when "N"
                res = "NEGRO"
            when "A"
                res = "AMARILLO"
            when "R"
                res = "ROJO"
            when "M"
                res = "MARRON"
            else
                res = personaje[i]
        end

        print "#{preg[1]}#{res}\n"
        i += 1
    end
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


#nuevo_personaje(personajes, preguntas)
print personajes


loop do
    mostrar_personajes(personajes)
    print "\nIngrese la ID del personaje que quiera expandir. Ingrese -1 para cerrar: "
    opt = gets.to_i
    loop do
        if opt >= -1 and (personajes[opt] != nil or opt == -1)
            break
        else
            print "Ingrese una ID válida para continuar o -1 para cerrar: "
            opt = gets.to_i
        end
    end
    break if opt == -1
    mostrar_caracteristicas(personajes[opt], preguntas)
end

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
