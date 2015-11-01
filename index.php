<?php
/*
LGPL http://www.gnu.org/licenses/lgpl.html
© 2012–2013 frederic.glorieux@fictif.org
© 2013–2015 frederic.glorieux@fictif.org et LABEX OBVIL

*/

include dirname(__FILE__).'/Tei2epub.php';
include dirname(__FILE__).'/Web.php'; // Tothink, better lib 
if (file_exists($dir=dirname(dirname(__FILE__)).'/Odette/')) include($dir.'Odt2tei.php');
// Post submit
$upload = Phips_Web::upload();
if ($upload) {
  if ($upload['extension'] == 'xml' || $upload['extension'] == 'tei') $teifile = $upload['tmp_name'];
  else if ($upload['extension'] == 'odt' && class_exists('Odette_Odt2tei')) {
    $odt=new Odette_Odt2tei($upload['tmp_name']);
    $teifile = dirname($upload['tmp_name']).'/'.$upload['filename'].'.xml';
    $odt->save($teifile, null, array('force'=>true));
    // may copy teifile
    if (is_dir($dir = dirname(__FILE__).'/tei/') && is_writable($dir)) copy($teifile, $dir.basename($teifile));
  }
  if (isset($_REQUEST['html'])) {
    header ("Content-Type: text/html; charset=UTF-8");
    echo $dom->saveXML();
    exit;
  }
  else if (isset($_REQUEST['tei'])) {
    header ("Content-Type: text/xml");
    $livre = new Livrable_Tei2epub($teifile);
    $dom = $livre->transform(dirname(dirname(__FILE__)) . '/Transtei/tei2html.xsl');
    echo file_get_contents($teifile);
    exit;
  }
  else {
    header('Expires: 0');
    header('Cache-Control: ');
    header('Pragma: ');
    header('Content-Type: application/epub+zip');
    header('Content-Disposition: attachment; filename="'.$upload['filename'].'.epub"');
    header('Content-Description: File Transfer');
    $livre = new Livrable_Tei2epub($teifile);
    $destfile = $livre->epub(); // return the epub filename created in tmp
    echo file_get_contents($destfile);
    exit();
  }
}
  
$action='index.php';
$lang = Phips_Web::lang();


?><!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" type="text/css" href="http://svn.code.sf.net/p/obvil/code/dynhum/html.css" />
    <link rel="stylesheet" type="text/css" href="http://svn.code.sf.net/p/obvil/code/theme/obvil.css" />
    <title><?php
if ($lang=='fr') echo'Livrable';
else echo 'Livrable'
    ?></title>
    </head>
  <body>
    <div id="center">
      <header id="header">
        <h1>
          <a href="../">Développements</a>
        </h1>
        <a class="logo" href="http://obvil.paris-sorbonne.fr/developpements/"><img class="logo" src="../theme/img/logo-obvil.png" alt="OBVIL"></a>
      </header>
      <div id="contenu">

<?php
if ($lang=='fr') echo '
  <span class="bar langBar">[ fr |<a href="?lang=en"> en </a>]</span> 
  <h1>Livrable, vous livre un livre électronique (epub) à partir d’un fichier traitement de textes stylé (odt) ou XML/TEI</h1>
  <p class="byline">par Frédéric Glorieux</p>
';
else echo '
  <span class="bar langBar">[ en |<a href="?lang=fr"> fr </a>]</span> 
  <h1>Livrable, deliver epub books from Word Processor file with styles (odt) or XML/TEI</h1>
  <p class="byline">by Frédéric Glorieux</p>
';
?>
      <form class="center"
        action="<?php echo $action; ?>"
        enctype="multipart/form-data" method="POST" name="upload" target="_blank"
       >
       <script type="text/javascript">
function changeAction(form, ext){var filename=form.file.value;var pos=filename.lastIndexOf('.'); if(pos>0) filename=filename.substring(0, pos); form.action='index.php/'+filename+ext; }
       </script>
        <?php
if ($lang=='fr') {
echo '<p>1. Choisissez un de vos fichiers odt ou XML/TEI</p>
<input type="file" size="70" name="file" accept=".xml,.tei,.odt"/>
<p>2. Vérifiez l’apparence générale dans une page écran</p>
<button name="html" onmousedown="changeAction(this.form, \'.html\'); " title="Transformation vers HTML" type="submit">HTML</button>
<button name="tei" onmousedown="changeAction(this.form, \'.xml\'); " title="Transformation vers TEI" type="submit">XML/TEI</button><p>3. Télécharger le livre électronique (epub)</p>
<button name="epub" onmousedown="changeAction(this.form, \'.epub\')" title="Transformation vers EPUB" type="submit">EPUB</button>
';} else {
echo '<p>1. Choose one of your odt or XML/TEI file</p>
<input type="file" size="70" name="file" accept=".xml,.tei,.odt"/>
<p>2. Check if transformation is correct in a popup page</p>
<button name="html" onmousedown="changeAction(this.form, \'.html\'); " title="Transform to HTML" type="submit">HTML</button>
<button name="tei" onmousedown="changeAction(this.form, \'.xml\'); " title="Transform to TEI" type="submit">XML/TEI</button>
<p>3. Download the electronic book (epub)</p>
<button name="epub" onmousedown="changeAction(this.form, \'.epub\')" title="Transform to EPUB" type="submit">EPUB</button>
';
}        
        ?>
      </form>
      <?php
if ($lang=='fr') echo '
<div>
  <ul>
    <li>Pour un livre avec table des matières, utiliser les styles de titres hiérarchiques (Titre 1, Titre 2…)</li>
    <li>Pour transmettre des métadonnées à votre bibliothèque, ajouter en tête de fichier des paragraphes commençant par une propriété <a href="http://dublincore.org/documents/dces/">Dublin Core</a> :
      <ul>
        <li>title: Titre du livre</li>
        <li>creator: Nom, Prénom (nom d’usage d’abord pour l’ordre alphabétique)</li>
        <li>date: date de première publication</li>
        <li>source: http://… (source initiale dont le fichier est tiré, pour créditer)</li>
      </ul>
    </li>
  </ul>

      <p>
Si vous n’êtes pas satisfait, <a href="#" onmouseover="if(this.ok)return; this.href=\'mai\'+\'lt\'+\'o:frederic.glorieux\'+\'\\u0040\'+\'fictif.org\'; this.ok=true">écrivez moi</a>, je serais content de vous satisfaire.
      </p>
     
</div>
      ';
else echo '
<div>
  <ul>
    <li>For a table of contents, use hierarchical styles in odt (Title 1, Title 2…)</li>
    <li>To have metadatas in your epub library, add some paragraphs at the top of your odt file with a <a href="http://dublincore.org/documents/dces/">Dublin Core</a> property :
      <ul>
        <li>title: Title Of Your Book</li>
        <li>creator: Family Name, First Name (in this order for alphabetic sort)</li>
        <li>date: date of first publication</li>
        <li>source: http://… (credit the initial source of the file)</li>
      </ul>
    </li>
  </ul>

      <p>
For any bug or feature, <a href="#" onmouseover="if(this.ok)return; this.href=\'mai\'+\'lt\'+\'o:frederic.glorieux\'+\'\\u0040\'+\'fictif.org\'; this.ok=true">mail me</a>.
      </p>
</div>
      ';
 
      
      ?>
      </div>
     </div>
  </body>
</html>
