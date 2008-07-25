//
//  MusicNote.h
//  MusicFoundation
//
//  Representa una nota musical. Tiene un valor de 1 a 7,
//  un indicador de sostenido/bemol y la octava en la que va.
//
//  Created by Enrique Zamudio Lopez on 18/07/08.
//  Copyright 2008 Desarrollo de Soluciones Abiertas, S.C.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SFCMusicNote : NSObject<NSCopying> {

    unsigned short nota;
    unsigned short octava;
    short sf; //sharp or flat
}

+ (SFCMusicNote *)note:(unsigned short)note  octave:(unsigned short)octave sharpOrFlat:(short)sb;

//Devuelve la nota con el nombre indicado. El nombre de una nota debe empezar
//indicando la nota misma, seguido de un bemol o sostenido opcional, y finalmente
//la octava (tambien opcional; si no se indica se usa octava 3).
+ (SFCMusicNote *)noteWithName:(NSString *)name;

- initWithNote:(unsigned short)note octave:(unsigned short)octave sharpOrFlat:(short)sb;

- (unsigned short)note;
- (unsigned short)octave;
- (short)sharpOrFlat;

//Devuelve el nombre de la nota, incluyendo al final la octava en la que va.
- (NSString *)name;
- (NSString *)nameWithoutOctave;

//Devuelve una nueva nota igual al receptor pero una octava mas arriba
- (SFCMusicNote *)nextOctave;
//Devuelve una nueva nota igual al receptor pero una octava mas abajo
- (SFCMusicNote *)prevOctave;

//Devuelve el semitono correspondiente a esta nota. Es un valor que va de 1 a 12.
- (unsigned short)semitone;

//Sube o baja la nota tantos semitonos como se indica.
- (void)transpose:(short)interval;

//Devuelve una nota basada en el receptor pero transpuesta tantos semitonos
//como se indique.
- (SFCMusicNote *)transposedNote:(short)interval;

//Convierte un sostenido en bemol o viceversa, manteniento la misma nota
//Por ejemplo C# se convierte en Db o Bb en A#.
- (void)swapSharpAndFlat;

@end
