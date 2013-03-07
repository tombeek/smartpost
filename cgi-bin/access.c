mozilla/extensions/tidy/tidy/src/access.c | 2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mozilla/extensions/tidy/tidy/src/access.c b/mozilla/extensions/tidy/tidy/src/access.c
index 54583d5..b22eb0d 100644
--- a/mozilla/extensions/tidy/tidy/src/access.c
+++ b/mozilla/extensions/tidy/tidy/src/access.c
@@ -2828,7 +2828,7 @@ static Bool CheckMetaData( TidyDocImpl* doc, Node* node, Bool HasMetaData )
}

if ( !HasMetaData &&
- nodeIsTITLE(node) &&
+ !nodeIsTITLE(node) &&
TY_(nodeIsText)(node->content) )
{
ctmbstr word = textFromOneNode( doc, node->content );