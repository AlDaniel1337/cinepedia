import 'package:cinepedia/src/domain/datasources/local_storage.datasource.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource{

  late Future<Isar> db;

  IsarDatasource(){
    db = openDB();
  }

  /// Inizializar / Obtener base de datos local
  Future<Isar> openDB() async {

    // Obtener path de archivos
    final dir = await getApplicationDocumentsDirectory();

    //+ Crear nueva instancia y devolverla
    if(Isar.instanceNames.isEmpty){
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path
      );
    }

    // regresar instancia si ya esta abrierta la base de datos
    return Future.value( Isar.getInstance() );
  }
  
  @override
  /// Revisar si la pelicula esta en favoritos
  Future<bool> isMovieFavorite(int movieId) async {

    final isar = await db;

    // Revisar si la pelicula esta en favoritos
    final Movie? isFavoriteMovie = await isar.movies
      .filter()
      .idEqualTo( movieId )
      .findFirst();

    return isFavoriteMovie != null;

  }

  @override    
  /// Obtener peliculas de acuerdo al offset y limit establecidos
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    
    final isar = await db;

    // Obtener peliculas de acuerdo al offset y limit establecidos
    return isar.movies
      .where()
      .offset(offset)
      .limit(limit)
      .findAll();

  }


  @override
  /// Cambiar estado de favorito de la pelicula enviada.
  /// Ademas de almacenar o eliminar la informacion en la base de datos local 
  Future<void> toggleFavorite(Movie movie) async {
    
    final isar = await db;
    
    // Obtener pelicula (en caso de que sea favorita)
    final favoriteMovie = await isar.movies
    .filter()
    .idEqualTo( movie.id )
    .findFirst();

    if( favoriteMovie != null ){
    //+ Borrar si ya esta en favoritos

      isar.writeTxnSync( () => isar.movies.deleteSync( favoriteMovie.isarId! ));

    }else{
    //- Inserta si no es favorita

      isar.writeTxnSync( () => isar.movies.putSync( movie ));

    }
  }


}