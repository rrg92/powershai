---
external help file: powershai-help.xml
schema: 2.0.0
powershai: true
---

# Invoke-PowerhsaiConsoleDraw

## SYNOPSIS <!--!= @#Synop !-->
Crea un riquadro virtuale di testo e scrive caratteri all'interno dei limiti di tale riquadro

## DESCRIPTION <!--!= @#Desc !-->
Crea un riquadro di disegno nel console, che viene aggiornato solo in una specifica regione!
Puoi inviare più righe di testo e la funzione si occuperà di mantenere il disegno nello stesso riquadro, dando l'impressione che solo una regione venga aggiornata.
Per l'effetto desiderato, questa funzione deve essere richiamata ripetutamente, senza altri writes tra le invocazioni!

Questa funzione deve essere utilizzata solo in modalità interattiva di powershell, in esecuzione in una finestra del console.
È utile da usare in situazioni in cui si desidera vedere il progresso di un risultato in stringa esattamente nella stessa area, potendo così confrontare meglio le variazioni.
È solo una funzione ausiliaria.

## SYNTAX <!--!= @#Syntax !-->

```
Invoke-PowerhsaiConsoleDraw [[-Text] <Object>] [[-w] <Object>] [[-h] <Object>] [[-BlankChar] <Object>] [[-PipeObj] <Object>] [-PassThru] [<CommonParameters>]
```

## EXAMPLES <!--!= @#Ex !-->

### EXAMPLE 1
```powershell
Il seguente esempio scrive 3 stringhe di testo ogni 2 secondi.
```


## PARAMETERS <!--!= @#Params !-->

### -Text
Testo da scrivere. Può essere un array. Se supera i limiti di W e H, verrà troncato
Se è un blocco di script, invoca il codice passando l'oggetto del pipeline!

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 1
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -w
Max di caratteri in ogni riga

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 2
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -h
Max di righe

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 3
Default Value: 10
Accept pipeline input: false
Accept wildcard characters: false
```

### -BlankChar
Carattere utilizzato come spazio vuoto

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 4
Default Value: 
Accept pipeline input: false
Accept wildcard characters: false
```

### -PipeObj
Oggetto del pipeline

```yml
Parameter Set: (All)
Type: Object
Aliases: 
Accepted Values: 
Required: false
Position: 5
Default Value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: false
```

### -PassThru
Re-invia l'oggetto

```yml
Parameter Set: (All)
Type: SwitchParameter
Aliases: 
Accepted Values: 
Required: false
Position: named
Default Value: False
Accept pipeline input: false
Accept wildcard characters: false
```




<!--PowershaiAiDocBlockStart-->
_Tradotto automaticamente tramite PowerShell e IA. 
_
<!--PowershaiAiDocBlockEnd-->
