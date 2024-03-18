import 'package:flutter/material.dart';

class Cabecalho {
  final String titulo;
  final String imagePath;
  Cabecalho(this.titulo, this.imagePath);

  cabecalho() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
            borderRadius: BorderRadius.circular(50),
            color: Color.fromARGB(255, 0, 0, 0)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              titulo,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  overflow: TextOverflow.ellipsis),
            ))
          ],
        ),
      ),
    );
  }
}
